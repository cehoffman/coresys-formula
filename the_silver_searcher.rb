class TheSilverSearcher < Coresys::Formula
  url 'https://github.com/ggreer/the_silver_searcher/tarball/0.13.1'
  sha1 'd7f2a1b421d915ecd38858f0e2b993686dce4095'

  def install
    # Stable tarball does not include pre-generated configure script
    # system "aclocal -I #{Coresys.base}/share/aclocal"
    system 'aclocal'
    system 'autoconf'
    system 'autoheader'
    system 'automake', '--add-missing'

    system './configure', '--disable-dependency-tracking', "--prefix=#{prefix}"
    system 'make'
    system 'make', 'install'
  end
end
