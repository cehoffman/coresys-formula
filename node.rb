class Node < Coresys::Formula
  url 'http://nodejs.org/dist/v0.8.17/node-v0.8.19.tar.gz'
  sha1 '65d22e4e183cee8888c797300d8fdbb5c530c740'

  def install
    system './configure', "--prefix=#{prefix}"
    system 'make', 'install'
  end
end
