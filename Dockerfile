FROM pivotaldata/gpdb-dev:centos6-gpadmin

ENV YUM_REPOFILE_URL "http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.2.0/hdp.repo"

RUN cd /etc/yum.repos.d && sudo wget -q ${YUM_REPOFILE_URL} && \
    sudo yum install -y hadoop-client && sudo yum clean all

COPY pxf.tar.gz /tmp
COPY startup-container.bash /

RUN mkdir -p /usr/local/gpdb
RUN tar xzf /tmp/pxf.tar.gz -C /usr/local/gpdb

EXPOSE 5888

CMD ["/startup-container.bash"]
