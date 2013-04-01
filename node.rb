class Node < Coresys::Formula
  url 'http://nodejs.org/dist/v0.10.2/node-v0.10.2.tar.gz'
  sha1 '759a05eff48ff0b54e55748012c5c45502f7cecd'

  def install
    system './configure', "--prefix=#{prefix}"
    system 'make', 'install'
  end
end
