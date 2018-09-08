> https://docs.hortonworks.com/HDPDocuments/Ambari-2.7.0.0/bk_ambari-installation/content/setting_up_a_local_repository.html

```
cd /etc/yum.repos.d/
wget http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.7.0.0/ambari.repo
wget http://public-repo-1.hortonworks.com/HDP/centos7/3.x/updates/3.0.0.0/hdp.repo
wget http://public-repo-1.hortonworks.com/HDF/centos7/3.x/updates/3.0.0.0/hdf.repo

mkdir -p ambari/centos7
cd ambari/centos7
reposync -r ambari-2.7.0.0

mkdir -p hdp/centos7
cd hdp/centos7
reposync -r HDP-3.0.0.0
reposync -r HDP-UTILS-1.1.0.22

mkdir -p hdf/centos7
cd hdf/centos7
reposync -r HDF-3.0.0.0

createrepo ambari/centos7/ambari-2.7.0.0
createrepo hdp/centos7/HDP-3.0.0.0
createrepo hdp/centos7/HDP-UTILS-1.1.0.22
createrepo hdf/centos7/HDF-3.0.0.0
```
