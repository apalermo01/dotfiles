final: prev: 

{
    curl = prev.curl.override {
      gnutlsSupport = true;
      opensslSupport = false;
    };

}
