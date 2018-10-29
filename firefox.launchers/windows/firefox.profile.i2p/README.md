
### Manual Setup (Windows) [Standalone guide](WINDOWS.md)

  0. Install Firefox ESR on your platform. [It can be obtained here](https://www.mozilla.org/en-US/firefox/organizations/)
  ESR stands for Extended Support Release, and it's the most "stable" branch of
  Firefox. If you already have Firefox ESR, you can safely skip this step.
  1. Download the profile release bundle from here. It is a zip file, which
  contains the profile we will be using with Firefox for our i2p-based browsing.
  2. Right-click the i2pbrowser-profile.zip and unzip the the profile into your
  Documents/Downloads folder by selecting "Extract All." You should be
  extracting this directly into your "Downloads" Folder, where the zipped file
  will create it's own subfolder automatically.

![Figure A: Extract All](images/extractall.png)

  3. Go to your desktop, right click, and select "Create Shortcut." Where it
  says "Type the location of the item:," Copy and paste the following line

        "C:\Program Files (x86)/Mozilla Firefox/firefox.exe" -no-remote -profile %CSIDL_DEFAULT_DOWNLOADS%/firefox.profile.i2p

Before:
![Figure B: Create Shortcut](images/shortcut.png)

After:
![Figure C: Create Shortcut](images/shortcut.png)

  4. Click "Done" and double-click your new shortcut. Type i2p-projekt.i2p into
  the address bar to test your i2p connectivity.
