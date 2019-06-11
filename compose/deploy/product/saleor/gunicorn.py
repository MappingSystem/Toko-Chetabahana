"""gunicorn WSGI server configuration."""
"""Usage: gunicorn -c saleor/gunicorn.py saleor.wsgi"""

from multiprocessing import cpu_count
from os import environ


def max_workers():
    return cpu_count()


bind = '0.0.0.0:' + environ.get('PORT', '80')
workers = max_workers()
worker_class = 'gevent'
max_requests = 100
timeout = 120

