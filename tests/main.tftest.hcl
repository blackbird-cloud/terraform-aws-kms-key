mock_provider "aws" {}

run "plan" {
  command = plan
  variables {
    name = "test-key"
  }
}
