## What is Version Control?
Version control is a system for recording changes to a project over time, so that they can be retrieved, or past versions can be reverted to if desired.

It's obvious why version control is helpful in pretty much any project. Even if we never intend to revert back to previous versions, it can be helpful to have a detailed history of how the project evolved for future reference and educational puproses for new team members. A version control system also provides us with backups of our data, although of course if the backup data is on the same local computer with the current version, this isn't that helpful. Also, local version control makes collaborting difficult.

Beyond just backups and redundancy, in software in particular, often we do want to revert to previous versions, particularly when the latest version has serious bugs. Given how complex software projects can be, reverting to a previous version without a version control system would be extremely frustrating.

Of course, one of way of doing version control is to simply save copies of old versions. This can get unweildy and difficult to manage very fast. It can also be very inefficient, since copying files reuses the entire file size even though the changes themsleves may be small and able to described compactly. Version control systems help you reliabily and efficiently manage this process, minimzing error and resources used thorugh clever design and storage.

![Local VCS](https://git-scm.com/book/en/v2/images/local.png)*All diagrams in this section from Pro Git 2nd Ed. Chapter 1.1*

### Centralized Version Control
Another way of doing version control is with a central server that serves as the authority/source of truth. This is a system used by by many collabarative apps such as Google Docs. There is a single, authoritative version of the file on Google's servers, which you must connect to in order to view and edit the file. Of course, you can downaload and save a local copy of the file, but once you do it becomes detached from the project and further edits. It's just a snapshot of the project at one instance.

Clearly in this model, collaborating is mucuh easier. Another advantage of this is that there is now a copy of the file(s) at a remote site which the users are not responsible for. Howevere, there are some disadvantages. Since all edits are in realtime, it can also be hard to coordinate and work on the same section, since people will be constantly writing over each other. Also. while the data is now managed by a third party, we still have to trust that the third party will not lose our data, i.e. like in the local case, We still have a single point of failure.

![Centralized VCS](https://git-scm.com/book/en/v2/images/centralized.png)

### Distributed Version Control
Git is a distributed version control system. It allows us to make use of the previous paradigms and their advantages if we want, while also mitigiating their disadvantages. Like the central VCS setup, if we want, we can still have a central authoritative server as the source of truth. However, all the users will also have copies of the full project and thus if the server ever goes down or the data gets corrupted, we can recover the full (or almost full) project and history from one of the users. We no longer have to rely solely on the server or hosting provider.

Since everyone has a complete copy of the project and its history, they can also work independently and asynchronously without interfering with eachother, unlike in real time Google Docs. The main disadvantage of this setup is that it can be more complex and has a bit of a learning curve compared to the previous setups.

![Distributed VCS](https://git-scm.com/book/en/v2/images/distributed.png)
