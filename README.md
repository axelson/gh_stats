# GhStats

Periodically polls GitHub collecting stats about a GitHub repository (or multiple repositories)

The stats can be used to understand the historical trends of Pull Requests such as:
- How long are Pull Requests typically waiting for review?
- Which developers Pull Requests wait the longest for review
- Which developers are reviewing the most Pull Requests

## How it works

- `PollGitHubWorker` runs every minute (hour) and polls GitHub to get the status of PRs
  - Stats are stored in Postgres
- `/api` simple JSON REST api
- Basic Phoenix UI to display stats
