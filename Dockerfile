FROM eyedeekay/tbb-docker
COPY bookmarks.html \
    /home/anon/tor-browser_en-US/Browser/TorBrowser/Data/Browser/profile.default/bookmarks.html
COPY user.js \
    /home/anon/tor-browser_en-US/Browser/TorBrowser/Data/Browser/profile.default/user.js
CMD /home/anon/tor-browser_en-US/Browser/start-tor-browser
