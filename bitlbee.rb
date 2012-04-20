class Bitlbee < Coresys::Formula
  url 'http://get.bitlbee.org/src/bitlbee-3.0.5.tar.gz'
  digest :sha1, '74afdff87be49ce060771a6ae10d7643cd57b9b6'

  def install
    system './configure', "--prefix=#{prefix}",
           "--config=#{etc}/bitlbee",
           '--msn=0',
           '--yahoo=0',
           '--events=libevent'
    system 'make'
    system 'make', 'install'
  end
end
