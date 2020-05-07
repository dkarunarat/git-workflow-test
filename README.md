# Git Workflow Test

Dillinger is a cloud-enabled, mobile-ready, offline-storage, AngularJS powered HTML5 Markdown editor.

  - Type some Markdown on the left
  - See HTML in the right
  - Magic

## The main branches
The central repo holds two main branches with an infinite lifetime:
   - master
   - dev
  
The master branch at origin should be familiar to every Git user. Parallel to the master branch, another branch exists called dev.
Consider ***origin/master*** to be the main branch where the source code of HEAD always reflects a production-ready state.

Consider ***origin/dev*** to be the main branch where the source code of HEAD always reflects a state with the latest delivered development changes for the next release. Some would call this the “integration branch”. When the source code in the develop branch reaches a stable point and is ready to be released, all of the changes should be 
   1. merged back into master 
   2. tagged with a release number. 

*How this is done in detail will be discussed further on*.

If this approach is followed, then theoretically, we could use a Git hook script to automatically build and roll-out software to production servers everytime there was a commit on master.

## Supporting branches 
Next to the main branches master and develop, supporting branches can be used to aid parallel development between team members, ease tracking of features, prepare for production releases and to assist in quickly fixing live production problems. ***Unlike the main branches, these branches always have a limited life time***, since they will be removed eventually.

These branches are categorized by how they are used:
   - Feature branches
   - Release branches
   - Hotfix branches
  
Each of these branches have a specific purpose and are bound to strict rules as to which branches may be their **originating branch** and which branches must be their **merge targets**. 