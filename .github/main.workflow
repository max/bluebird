workflow "build and test" {
  on = "push"
  resolves = "test"
}

action "prepare" {
  uses = "docker://alpine/git"
  args = ["submodule", "update", "--init", "--recursive"]
}

action "install" {
  needs = ["prepare"]
  uses = "actions/npm@master"
  args = ["install"]
}

action "test" {
  needs = ["install"]
  uses = "actions/npm@master"
  runs = ["node", "--expose-gc", "tools/test.js"]
}
