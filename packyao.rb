require 'json'

version = '0.0.1'

a = {}
a['name'] = 'sneaker'
a['version'] = version
a['source'] = 'https://github.com/codahale/sneaker.git'
a['type'] = 'git'
a['license'] = 'Apache'
a['commands'] = [
  <<-EOF
  apt-get update
  apt-get -y install wget curl git make
  wget https://storage.googleapis.com/golang/go1.5.2.linux-amd64.tar.gz
  tar xfz go1.5.2.linux-amd64.tar.gz -C /usr/local
  go get -d -u github.com/codahale/sneaker
  cd $GOPATH/src/github.com/codahale/sneaker
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
a['package_files'] = {
  '/root/go/bin/sneaker' => '/usr/local/bin/sneaker',
  '/root/go/bin/darwin_amd64/sneaker' => '/tmp/osx/sneaker'
}
a['build_distro'] = 'ubuntu'
a['build_distro_version'] = '14.04'

File.write('packyao.json', JSON.pretty_generate(a))
