# Kickoff Report

[View the live site](https://kickoff-report.o-ganser.workers.dev/)

Kickoff Report forecasts NFL regular-season matchups. The dashboard shows each team's win probability, projected score, and the model's pick. After nflverse posts a final score, the site displays it alongside the saved pregame prediction and marks the pick as correct, incorrect, or tied.

## How the model works

The model uses each team's points scored and allowed over its last five completed games, days of rest, home-field status, and the pregame Elo rating difference. Elo updates after each game based on the result and the opponent's rating. Features use results available before the matchup.

A logistic regression model estimates the home team's win probability. A separate ridge regression model projects both teams' scores. The [Python notebook](nfl_predictions.ipynb) builds the features, fits the models, and compares them across seasons. The deployed Worker uses the fitted weights and recalculates the inputs as new results come in.

## Model evaluation

Winner accuracy was measured on regular-season games with a winner. The 2022–2024 column averages three season-by-season validation runs trained on earlier seasons. The 2025 reference comparison uses models trained through 2023.

| Model | 2022–2024 average validation accuracy | 2025 reference accuracy |
|---|---:|---:|
| Baseline (recent scoring, rest, home field) | 60.6% | 63.1% |
| Baseline + EPA | 60.8% | 62.0% |
| Elo only | 63.8% | 63.1% |
| **Baseline + Elo** | **64.8%** | **63.8%** |

Baseline + Elo improved on the baseline in all three validation seasons and was selected for deployment. A separate replay of 1,084 games from 2022–2025 compared refreshing the inputs each week with also refitting the model each week. The fixed model picked **704** winners correctly versus **701** with weekly refitting. That result informed the decision to refresh the inputs weekly and keep the weights fixed during the season.

## Forecast and results updates

- A Cloudflare Cron Trigger refreshes forecasts on Tuesdays at **9:15 a.m. Central** during the configured 2026 season window.
- The Worker saves each verified forecast to Cloudflare R2 and keeps earlier pregame predictions for comparison with final scores.
- The dashboard checks for final scores when opened and every two minutes while visible. Final scores appear after nflverse publishes them.
- The bundled forecast CSV provides the initial snapshot before the first successful refresh.

## Run locally

Install Node.js and npm. From the repository root, run:

```bash
npx wrangler dev
```

Open the local URL Wrangler prints. To reproduce the model evaluation, open `nfl_predictions.ipynb` in Jupyter or VS Code. The notebook uses pandas, NumPy, scikit-learn, PyArrow, and certifi. It can download the schedule and play-by-play data, or load a local `games.csv`.

## Deploy on Cloudflare

Enable R2 on your Cloudflare account, then run:

```bash
npx wrangler login
npx wrangler r2 bucket create kickoff-report-forecasts
npx wrangler deploy
```

Use the existing bucket if you already created it. If you choose a different name, update `bucket_name` in `wrangler.jsonc`. Wrangler runs `node build.mjs` and prints the deployed URL. The included Worker, frontend, and refresh dates are configured for the **2026 regular season**.

## Repository layout

| Path | Contents |
|---|---|
| `nfl_predictions.ipynb` | Feature engineering, model comparison, and forecast export |
| `web/` | Dashboard HTML, CSS, JavaScript, and bundled forecast CSV |
| `worker/` | Forecast updater, final-score feed, and fitted model weights |
| `build.mjs` | Bundles the dashboard and Worker |
| `wrangler.jsonc` | Cloudflare configuration, R2 binding, and Cron schedule |

## Data sources

- [nflverse schedules and game results](https://github.com/nflverse/nfldata/blob/master/data/games.csv)
- [nflverse play-by-play data](https://github.com/nflverse/nflverse-data/releases/tag/pbp) for the expected points added (EPA) experiment
