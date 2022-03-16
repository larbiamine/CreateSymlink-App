# CreateSymlink-App
A Qt GUI For Creating Symbolic links using symlink 

## What Are Symbolic Links?

Symbolic links are basically advanced shortcuts. Create a symbolic link to an individual file or folder, 
and that link will appear to be the same as the file or folder to Windows—even though it’s just a link pointing at the file or folder.

There are two type of symbolic links: Hard and soft. Soft symbolic links work similarly to a standard shortcut. When you open a soft link to a folder, you will be redirected to the folder where the files are stored.  However, a hard link makes it appear as though the file or folder actually exists at the location of the symbolic link, 
and your applications won’t know any better. That makes hard symbolic links more useful in most situations.

Here we are going to use hard links only, also known as *directory junction* when used with directories. 

Symbolic links can be used for all sorts of things, including syncing any folder with programs like Dropbox, Google Drive, and OneDrive.

You can create symbolic links using the **mklink** command in a Command Prompt window as Administrator:
`mklink Link Target`

Use /H when you want to create a hard link pointing to a file:

`mklink /H Link Target`

Use /J to create a hard link pointing to a directory, also known as a directory junction:

`mklink /J Link Target`

For a modern user interface we're using QtQuick with Material Design
<p align="center">
<img src="https://user-images.githubusercontent.com/51280073/158627119-a7550ba4-b0f0-4c4a-8ffb-67399d77be71.png" width="333" height="510">
<img src="https://user-images.githubusercontent.com/51280073/158627626-dcfcd4d3-1aed-4270-9007-0171e98831b2.png" width="333" height="510"> 
</p>



### Requirements:
PySide6==6.2.3
