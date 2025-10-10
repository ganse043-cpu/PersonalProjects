 # 🎵 Spotify Music Popularity Model

 A machine learning project used to research audio attributes in a spotify dataset that contribute the most to popularity.

 ## Overview

This project analyzes 4787 different songs from two datasets, high popularity songs, and low popularity songs. The goal is to identify which audio characteristics contribute most to a songs popularity score. 

## Research Questions

1. Which audio features are most correlated with popularity?
2. How much of a songs popularity can be explained by audio features?
3. 


## Dataset

### Source: [Kaggle Spotify Dataset](https://www.kaggle.com/datasets/solomonameh/spotify-music-dataset/data)

### Features:

- **Important audio features**: danceability, energy, loudness, speechiness, acousticness, instrumentalness, liveness, valence, tempo
- **Technical Attributes**: key, mode, time_signature, duration
- **Target Variable**: track_popularity(0-100 scale)

### Feature Description:

- **Energy**: A measure of intensity and activity. Typically, energetic tracks feel fast, loud, and noisy.
- **Tempo**: The speed of a track, measured in beats per minute (BPM).
- **Danceability**: A score describing how suitable a track is for dancing based on - tempo, rhythm stability, beat strength and overall regularity.
- **Loudness**: The overall loudness of a track in decibels (dB). Higher values indicate louder tracks overall.
- **Liveness**: The likelihood of a track being performed live. Higher values suggest more audience presence.
- **Valence**: The overall musical positiveness(emotion) of a track. High valence sounds happy; low valence sounds sad or angry.
- **Speechiness**: Measures the presence of spoken words.
- **Instrumentalness**: The likelihood a track contains no vocals. Values closer to 1.0 suggest solely instrumental tracks.
- **Mode**: Indicates the modality of the track.
- **Key**: The musical key, represented as an integer from 0 to 11, mapping to standard Pitch class notation.
- **Duration_ms**: The length of the track in milliseconds.
- **Acousticness**: A confidence measure of whether a track is acoustic(1) or not(0).


**Split track_popularity into four different ranges**: 

| Popularity Range | Count | Percentage |
|------------------|-------|------------|
| Low (0-40) | 1,180 | 25% |
| Medium (40-60) | 1,555 | 33% |
| High (60-80) | 1,691 | 36% |
| Very High (80-100) | 362 | 8% |

## Research

### Popularity Distribution:
![popdist](./PopularityDist.png)

### Feature Correlation:
![feat_corr](./feat_corr.png)

### Relationships between variables and track popularity:

![](./accousticness.png)
![](./dancebility.png)
![](./instrumentallness.png)
![](./loudness.png)
![](./energy.png)
![](./genre.png)

### Key Findings: 

### Finding 1:  Loudness shows the strongest relationship to song popularity
 - Loudness has the highest correlation coefficient (0.22) with popularity.
 - The scatter plot clearly shows that Low popularity songs cluster at lower loudness levels (-30 to -10 dB)
- High and Very High popularity songs concentrate at higher loudness levels (-10 to 0 dB)
### Finding 2: Acousticness Negatively Correlates with Popularity
- Low popularity songs heavily represented in high acousticness range (0.5-1.0)
- Very High popularity songs concentrate in low acousticness range (0.0-0.3)
- Correlation coefficient: -0.23 (moderate negative)
### Finding 3: Instrumentalness Strongly Negative
- Nearly all Very High popularity songs have instrumentalness near 0 (vocal-focused)
- Low popularity includes many instrumental tracks (0.5-1.0 range)
- Correlation coefficient: -0.26 (strongest negative correlation)
- Songs with more vocals are likely to be more popular



