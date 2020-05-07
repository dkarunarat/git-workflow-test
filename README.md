
# Git Workflow

## Table of Contents
* [The main branches](#the-main-branches)
* [Supporting branches](#supporting-branches)
     - [Feature branches](#feature-branches)
          - [Creating a Feature branch](#creating-a-feature-branch)
          - [Incorporating a Feature into dev](#incorporating-a-feature-into-dev)
     - [Release branches](#release-branches)
	      - [Creating a release branch](#creating-a-release-branch)
          - [Finishing a release branch](#finishing-a-release-branch)

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

### Feature branches
> branch off from --> *dev* || merge back into --> *dev*

*TODO: Decide on branch naming convention

Eg:  
- feature/sauto-43
- SAUTO-43-description*

#### Creating a feature branch
Feature branches are used to develop new features for the upcoming or a distant future release.
When creating a new feature branch, ensure that you are have the latest version of the *dev* branch available.
```sh
$ git checkout dev
$ git pull origin dev
```
Create a local feature branch based on the *dev* branch. 
```sh
$ git checkout -b <feature-branch-name>
```

#### Incorporating a feature into dev
After committing work to the branch locally, push the commits to the remote repository and create a pull request from the feature branch to the *dev* branch on github. (*The -u flag is shorthand for --set-upstream which connects the local branch to its couterpart on the remote repository*)  

```sh
# Work on the branch and commit often
$ git commit

# push the branch to origin when you are ready to create a pull request
$ git push -u origin <feature-branch-name>
```

[Directions for creating pull requests on github](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request)

[blog post - Writing pull  requests](https://github.blog/2015-01-21-how-to-write-the-perfect-pull-request/)

After the PR is reviewed and approved, Merge it into the dev branch

### Release branches
> branch off from --> *dev* || merge back into --> *dev & master*

*TODO: Decide on branch naming convention

Eg:  
- release/0.0.1
- release-0.1.1*

Release branches support preparation of a new production release. They allow for last-minute changes, minor bug fixes and preparing meta-data for a release (version number, build dates, etc.). 

By doing all of this work on a release branch, the  `dev`  branch is cleared to receive features for the next big release.

The key moment to branch off a new release branch from  `dev`  is when dev (almost) reflects the desired state of the new release. At least all features that are targeted for the release-to-be-built must be merged in to  `dev`  at this point in time. All features targeted at future releases may not—they must wait until after the release branch is branched off.

It is exactly at the start of a release branch that the upcoming release gets assigned a version number—not any earlier. Up until that moment, the  `dev`  branch reflected changes for the “next release”, but it is unclear whether that “next release” will eventually become 0.3 or 1.0, until the release branch is started. That decision is made on the start of the release branch and is carried out by the project’s rules on version number bumping.

#### Creating a release branch

***This can be done on the github website  as well TODO: Check best way to do it*** 

Ensure that you are have the latest version of the *dev* branch available.
```sh
$ git checkout dev
$ git pull origin dev
```
Create a local release branch based on the *dev* branch.

```sh
$ git checkout -b <release-version> dev
```
This new release branch may exist for a while, until the release is rolled out definitely. During that time, bug fixes may be applied in this branch (rather than on the `dev` branch). Adding large new features here is strictly prohibited. They must be merged into `dev`, and therefore, must wait for the next big release.

#### Finishing a release branch

When the state of the release branch is ready to become a real release, some actions need to be carried out. First, the release branch is merged into `master` (since every commit on `master` is a new release *by definition*). Next, that commit on `master` must be tagged for easy future reference to this historical version.
 Finally, the changes made on the release branch need to be merged back into `dev`, so that future releases also contain these bug fixes

If the merge to master is being performed locally, 
```sh
#### Update the local copy of the release branch
$ git checkout release-0.0.1
$ git pull origin release-0.0.1

### Checkout master, update and merge with the release branch
$ git checkout master
$ git pull origin master
$ git merge --no-ff release-0.0.1

### Create a tag annotated with the version number
$ git tag -a 0.0.1 -m "Release 0.0.1"

### Push the commits along with the tags
$ git push --follow-tags
```
