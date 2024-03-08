From centos:7

env HF_ENDPOINT="https://hf-mirror.com"
env BASH_RC=/etc/bashrc

workdir /home/workdir

run yum install -y \
        zlib-devel bzip2-devel openssl-devel \
        ncurses-devel sqlite-devel readline-devel \
        tk-devel gcc make libffi-devel \
        xz-devel python-backports-lzma && \
    yum clean all && \
    mkdir -p python && \
    curl -sL https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz | \
        tar -zx -C python && \
    cd python/Python-3.9.0 && \
    ./configure prefix=/usr/local/python3 && \
    make && make install && \
    cd ../.. && rm -rf python && \
    echo 'export PATH=$PATH:/usr/local/python3/bin/' >> ${BASH_RC} && \
    ln -s /usr/local/python3/bin/python3.9 /usr/bin/python3 && \
    ln -s /usr/local/python3/bin/pip3.9 /usr/bin/pip 

add requirements.txt .
run pip install --upgrade pip && \
    pip install -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cpu && \
    pip cache purge

# run huggingface-cli download --revision 2024-03-05 vikhyatk/moondream2

add vision.py .

cmd ["/usr/local/python3/bin/streamlit", "run", "vision.py"]
