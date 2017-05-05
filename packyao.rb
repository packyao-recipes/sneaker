require 'json'

version = '0.0.1'
go_version = '1.8'

a = {}
a['name'] = 'sneaker'
a['version'] = version
a['license'] = 'Apache'
a['commands'] = [
  <<~EOF
  export GOPATH=${HOME}/go PATH=$PATH:$GOROOT/bin; env
  apt-get update
  apt-get -y install wget curl git make
  wget -nv https://storage.googleapis.com/golang/go#{go_version}.linux-amd64.tar.gz
  tar xfz go#{go_version}.linux-amd64.tar.gz -C /usr/local
  go get -d -u github.com/codahale/sneaker
  cd $GOPATH/src/github.com/codahale/sneaker
  for os in linux darwin; do
    GOOS=$os CGO_ENABLED=0 make install
  done
  EOF
]
a['depends'] = []
a['cwd'] = ''
a['env'] = {
  'GOROOT' => '/usr/local/go'
}
a['outputs'] = %w(deb rpm tar)
linux_bin = { '/root/go/bin/sneaker' => '/usr/local/bin/sneaker' }
osx_bin = { '/root/go/bin/darwin_amd64/sneaker' => '/tmp/osx/sneaker' }
a['package_files'] = {
  'deb' => linux_bin,
  'rpm' => linux_bin,
  'tar' => linux_bin.merge(osx_bin)
}
a['build_distro'] = 'ubuntu'
a['build_distro_version'] = '14.04'

File.write("#{File.dirname(__FILE__)}/packyao.json", JSON.pretty_generate(a))
