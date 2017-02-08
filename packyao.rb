require 'json'

version = '0.0.1'

a = {}
a['name'] = 'sneaker'
a['version'] = version
a['license'] = 'Apache'
a['commands'] = [
  <<~EOF
  apt-get update
  apt-get -y install wget curl git make
  wget -nv https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz
  tar xfz go1.6.2.linux-amd64.tar.gz -C /usr/local
  go get -d -u github.com/jietang/sneaker
  cd $GOPATH/src/github.com/jietang/sneaker
  for os in linux darwin; do
    GOOS=$os make install
  done
  EOF
]
a['depends'] = []
a['cwd'] = ''
a['env'] = {
  'GOROOT' => '/usr/local/go',
  'GOPATH' => '${HOME}/go',
  'PATH' => '$PATH:$GOROOT/bin'
}
a['outputs'] = %w(deb rpm tar)
linux_bin = {'/root/go/bin/sneaker' => '/usr/local/bin/sneaker'}
osx_bin = {'/root/go/bin/darwin_amd64/sneaker' => '/tmp/osx/sneaker'}
a['package_files'] = {
  'deb' => linux_bin,
  'rpm' => linux_bin,
  'tar' => linux_bin.merge(osx_bin)
}
a['build_distro'] = 'ubuntu'
a['build_distro_version'] = '14.04'

File.write('packyao.json', JSON.pretty_generate(a))
