# Start with a recent Ubuntu image, and run package updates.
FROM ubuntu:24.04

EXPOSE 8888

RUN apt-get update --fix-missing && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
                    ca-certificates=20240203 \
                    curl=8.5.0-2ubuntu10.5 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# First install conda, because jupyterlab is packaged by it.
RUN curl -O \
      https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh
RUN bash Anaconda3-2024.10-1-Linux-x86_64.sh -b -p /opt/conda && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete 

ENV PATH="$PATH:/opt/conda/bin"

RUN /opt/conda/bin/conda update -n base -c defaults conda && \
    /opt/conda/bin/conda clean -afy

# Use conda-forge to get Orekit, then download orekit data files.
RUN /opt/conda/bin/conda config --add channels conda-forge && \
    conda install orekit && \
    curl -O https://gitlab.orekit.org/orekit/orekit-data/-/archive/master/orekit-data-master.zip && \
    mv orekit-data-master.zip orekit-data.zip

CMD ["/opt/conda/bin/conda", "run", "jupyter", "lab", \
     "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser", \
     "--NotebookApp.token=''", "--NotebookApp.password=''"]
