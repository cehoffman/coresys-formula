class Luarocks < Coresys::Formula
  url 'http://luarocks.org/releases/luarocks-2.0.12.tar.gz'
  digest :sha1, 'bfa36d5a9931c240c0253dee09c0cfb69372d276'

  option 'luajit', 'Use LuaJIT as interpreter'

  depends_on 'luajit' if build.include? 'luajit'

  def install
    args = ["--prefix=#{prefix}",
            "--rocks-tree=#{Coresys.base}",
            "--sysconfdir=#{etc}/luarocks"]

    if build.include? 'luajit'
      args << "--with-lua-include=#{Coresys.base}/include/luajit-2.0"
      args << '--lua-suffix=jit'
    end

    system './configure', *args
    system 'make'
    system 'make', 'install'
  end
end
