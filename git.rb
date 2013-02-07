class GitManuals < Coresys::Formula
  url 'http://git-core.googlecode.com/files/git-manpages-1.8.1.2.tar.gz'
  digest :sha1, '142222a27dfec52256831f2d0e2ee655f75c1077'
end

class GitHtmldocs < Coresys::Formula
  url 'http://git-core.googlecode.com/files/git-htmldocs-1.8.1.2.tar.gz'
  digest :sha1, '3df491003d026b8f4b2de378e57b930a98f0a595'
end

class Git < Coresys::Formula
  homepage 'http://git-scm.com'
  url 'http://git-core.googlecode.com/files/git-1.8.1.2.tar.gz'
  digest :sha1, '29a2dee568b1f86e9d3d8f9dcc376f24439b6a0c'

  # head 'https://github.com/git/git.git'

  # depends_on 'pcre' if ARGV.include? '--with-pcre'

  def options
    [
      ['--with-blk-sha1', 'compile with the optimized SHA1 implementation'],
      ['--with-pcre', 'compile with the PCRE library'],
    ]
  end

  def install
    # If these things are installed, tell Git build system to not use them
    ENV['NO_FINK'] = '1'
    ENV['NO_DARWIN_PORTS'] = '1'
    ENV['V'] = '1' # build verbosely
    ENV['NO_R_TO_GCC_LINKER'] = '1' # pass arguments to LD correctly
    ENV['NO_GETTEXT'] = '1'
    # ENV['PERL_PATH'] = which 'perl' # workaround for users of perlbrew
    # ENV['PYTHON_PATH'] = which 'python' # python can be brewed or unbrewed

    ENV['BLK_SHA1'] = '1' if ARGV.include? '--with-blk-sha1'

    # if ARGV.include? '--with-pcre'
    #   ENV['USE_LIBPCRE'] = '1'
    #   ENV['LIBPCREDIR'] = HOMEBREW_PREFIX
    # end

    system "make", "prefix=#{prefix}",
                   # "CC=#{ENV.cc}",
                   # "CFLAGS=#{ENV.cflags}",
                   # "LDFLAGS=#{ENV.ldflags}",
                   "install"

    # install the completion script first because it is inside 'contrib'
    (prefix+'etc/bash_completion.d').install 'contrib/completion/git-completion.bash'
    (share+'git-core').install 'contrib'

    # We could build the manpages ourselves, but the build process depends
    # on many other packages, and is somewhat crazy, this way is easier.
    GitManuals.new.install { man.install Dir['*'] }
    GitHtmldocs.new.install { (share + 'doc/git-doc').install Dir['*'] }
  end

  def caveats; <<-EOS.undent
    Bash completion has been installed to:
      #{etc}/bash_completion.d

    The 'contrib' directory has been installed to:
      #{HOMEBREW_PREFIX}/share/git-core/contrib
    EOS
  end
end
