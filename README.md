# GhStats

Periodically polls GitHub collecting stats about a GitHub repository (or multiple repositories)

The stats can be used to understand the historical trends of Pull Requests such as:
- At any given time how the number of Pull Requests are ready and waiting for review
- At any given time how the number of Pull Requests have been approved but not merged
- At any given time how the number of Pull Requests are open (including draft)
- At any given time how the number of review requests are outstanding

Secondary stats:
- How long are Pull Requests typically waiting for review?
- Which developers Pull Requests wait the longest for review
- Which developers are reviewing the most Pull Requests

Doesn't currently handle some complexities such as:
- A PR that is converted back to draft and then becomes ready for review again

Assumes that we're only interested in reviews for non-draft PRs

## How it works

- `PollGitHubWorker` runs every minute (hour) and polls GitHub to get the status of PRs
  - Stats are stored in Postgres
- `/api` simple JSON REST api
- Basic Phoenix UI to display stats

## Installation

The preferred method of installation is via systemd

- Clone repository to ~/gh_stats
- Populate ~/gh_stats/.env
- Install gh_stats.service by following priv/gh_stats.service (customizing paths
  as necessary)
