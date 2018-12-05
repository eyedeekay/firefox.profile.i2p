FROM eyedeekay/tbb-docker:torbrowser
COPY firefox.profile.i2p/bookmarks.html \
    /home/anon/tor-browser_en-US/Browser/TorBrowser/Data/Browser/profile.default/bookmarks.html
COPY firefox.profile.i2p/user.js \
    /home/anon/tor-browser_en-US/Browser/TorBrowser/Data/Browser/profile.default/user.js
CMD /home/anon/tor-browser_en-US/Browser/start-tor-browser
