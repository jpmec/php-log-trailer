"""
Background service for Log Trailer app.
"""

__version__ = "0.0.0"


import json, os, signal, tempfile, time, threading




class LogTrailerThread(threading.Thread):
    """
    Thread for polling file stats.
    """

    def __init__(self, **kwargs):
        threading.Thread.__init__(self)
        self.event = threading.Event()
        self.interval = 2
        self.stats = {}
        self.files = kwargs['file_list']

    def run(self):
        while not self.event.is_set():

            (tfid, tfname) = tempfile.mkstemp()

            for filename in self.files:

                self.stats[filename] = None
                try:
                    stat = os.stat(filename)
                    self.stats[filename] = {
                        'size': stat.st_size,
                        'atime': stat.st_atime,
                        'ctime': stat.st_ctime,
                        'mtime': stat.st_mtime
                    }
                except OSError:
                    pass

            os.write(tfid, json.dumps(self.stats))
            os.rename(tfname, "stats.json")
            self.event.wait(self.interval)


    def stop(self):
        """
        Stop the thread
        """
        self.event.set()




if __name__ == '__main__':

    files = ['test.txt', '/private/var/log/apache2/error_log', 'does not exist']



    d = {
        'file_list': files
    }


    tmr = LogTrailerThread(**d)
    tmr.start()


    def signal_handler(signal, frame):
        tmr.stop()
        tmr.join()


    signal.signal(signal.SIGINT, signal_handler)
    print 'Press Ctrl+C to quit'
    signal.pause()

