---
title: Change and rebuild an RPM on CentOS
author: Rayed
type: post
date: 2016-05-29T20:24:14+03:00
draft: true
private: true
categories:
  - Uncategorized
tags:
  - centos
  - linux
  - rpm
wordpress_id: 1931

---
<p><code></p>
<pre>sudo yum groupinstall "Development Tools"
sudo yum install epel-release.noarch
sudo yum install yum-utils rpmdevtools

mkdir -p ~/rpmbuild/{SOURCES,SPECS}
wget http://example.com/lame-3.99.5.tar.gz
mv lame-3.99.5.tar.gz ~/rpmbuild/SOURCES
rpmdev-newspec lame
mv lame.spec ~/rpmbuild/SPECS
cat < < EOF > ~/rpmbuild/SPECS/lame.spec
# ------------------------------------------------------------
Name:           lame
Version:        3.99.5
Release:        1%{?dist}
Summary:        LAME MP3 Encoder

License:        N/A
Source0:        lame-3.99.5.tar.gz

%description
Educational tool to be used for learning about MP3 encoding. LAME aims to be the basis of a patent free audio compression codec.


%prep
%setup -q


%build
%configure
make %{?_smp_mflags}


%install
rm -rf $RPM_BUILD_ROOT
%make_install


%files
%doc
/usr/bin/lame
%dir /usr/include/lame
/usr/include/lame/*
/usr/lib64/*
/usr/share/doc/lame/html
/usr/share/man/man1/lame.1.gz

%changelog
# ------------------------------------------------------------
EOF
rpmbuild -ba ~/rpmbuild/SPECS/lame.spec
sudo rpm -Uvh ~/rpmbuild/RPMS/x86_64/lame-3.99.5-1.el7.centos.x86_64.rpm 


yumdownloader --source sox
sudo yum-builddep sox-14.4.1-6.el7.src.rpm 
rpm -i sox-14.4.1-6.el7.src.rpm 
vi ~/rpmbuild/SPECS/sox.spec
:  Add "--with-lame" to the configure line
%configure --with-lame
:
rpmbuild -ba ~/rpmbuild/SPECS/sox.spec 
sudo rpm -Uvh ~/rpmbuild/RPMS/x86_64/sox-14.4.1-6.el7.centos.x86_64.rpm
sox | grep mp3
</pre>
<p></code></p>
<p>References:<br />
https://fedoraproject.org/wiki/How_to_create_an_RPM_package</p>
