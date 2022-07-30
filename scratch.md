TODO:
* [ ] sparkline will have a set width and try to fill it up with whatever data we have but maxing out at a set amount of data points for each sparkline

https://docs.github.com/en/graphql/overview/explorer

```graphql
query {
  repository(name: "felt", owner: "felt") {
    pullRequests(
      last: 8
      orderBy: {field: CREATED_AT, direction: ASC}
      states: [OPEN]
    ) {
      totalCount
      edges {
        node {
          title
          isDraft
          deletions
          additions
          labels(first: 10) {
            nodes {
              id
              name
              color
            }
          }
          merged
          mergeable
          number
          reviewRequests(first: 10) {
            nodes {
              requestedReviewer {
                ... on User {
                  login
                }
              }
            }
          }
          url
          timelineItems(first: 100, itemTypes: [
            PULL_REQUEST_REVIEW,
            REVIEW_REQUESTED_EVENT,
            MERGED_EVENT,
            CLOSED_EVENT,
            REOPENED_EVENT,
            CONVERT_TO_DRAFT_EVENT,
            READY_FOR_REVIEW_EVENT
          ]) {
            nodes {
              __typename
              ... on ReviewRequestedEvent {
                requestedReviewer {
                  ... on Actor {
                    login
                  }
                }
              }
              ... on PullRequestReview {
                author {
                  login
                }
                publishedAt
                state
              }
              ... on ReadyForReviewEvent {
                createdAt
              }
              ... on ConvertToDraftEvent {
                createdAt
              }
              ... on MergedEvent {
                createdAt
              }
              ... on ClosedEvent {
                createdAt
              }
              ... on ReopenedEvent {
                createdAt
              }
            }
          }
          author {
            login
          }
          reviewDecision
        }
      }
    }
  }
}
```

```graphql
{
  viewer {
    login
  }
  repository(name: "felt", owner: "felt") {
    pullRequests(
      first: 100
      orderBy: {field: CREATED_AT, direction: ASC}
      states: [OPEN]
    ) {
      totalCount
      edges {
        node {
          title
          isDraft
          author {
            login
          }
          reviewDecision
        }
      }
    }
  }
}
```
