class Node < Coresys::Formula
  url 'http://nodejs.org/dist/v0.6.15/node-v0.6.15.tar.gz'
  digest :sha1, '5c52d8f91f221277fe69d0e5bf73d13d0f23038f'

  def install
    system './configure', "--prefix=#{prefix}"
    system 'make', 'install'
  end
end
