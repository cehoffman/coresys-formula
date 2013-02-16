class GitManuals < Coresys::Formula
  url 'http://git-core.googlecode.com/files/git-manpages-1.8.1.3.tar.gz'
  digest :sha1, '12aaa8a0428e64d194665379ab0335d786728930'
end

class GitHtmldocs < Coresys::Formula
  url 'http://git-core.googlecode.com/files/git-htmldocs-1.8.1.3.tar.gz'
  digest :sha1, '6b1e57bde2f2b0a86532390c15bfa7b181c50db2'
end

class Git < Coresys::Formula
  homepage 'http://git-scm.com'
  url 'http://git-core.googlecode.com/files/git-1.8.1.3.tar.gz'
  digest :sha1, '29ed9047263f9835726200226451339276641779'

  # head 'https://github.com/git/git.git'

  option 'blk-sha1', 'compile with the optimized SHA1 implementation'
  option 'pcre',  'compile with the PCRE library'

  depends_on 'pcre' if ARGV.include?('--with-pcre')

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

    cd 'contrib/subtree' do
      system 'make'#, "CC=#{ENV.cc}",
                     # "CFLAGS=#{ENV.cflags}",
                     # "LDFLAGS=#{ENV.ldflags}"
      bin.install 'git-subtree'
    end

    bash_completion.install 'contrib/completion/git-completion.bash'
    bash_completion.install 'contrib/completion/git-prompt.sh'
    zsh_completion.install 'contrib/completion/git-completion.zsh' => '_git'

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
      #{Coresys.base}/share/git-core/contrib
    EOS
  end
end
