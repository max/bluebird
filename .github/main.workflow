workflow "build and test" {
  on = "push"
  resolves = "test"
}

action "prepare" {
  uses = "docker://alpine/git"
  args = ["submodule", "update", "--init", "--recursive"]
}

action "test" {
  needs = ["prepare"]
  uses = "actions/npm@master"
  runs = ["node", "--expose-gc", "tools/test.js"]
}
