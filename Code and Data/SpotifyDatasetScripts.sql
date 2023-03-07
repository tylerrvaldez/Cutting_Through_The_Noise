-- Q1 Listeners preferred music genres. 

-- Q1.1 Listener popularity based on songs within different genres
select distinct genre, avg(popularity) AS 'average popularity'
from SpotifyFeatures
group by genre
order by avg(popularity) desc

-- Q1.2 Taking the top 50 tracks to see what genre is associated most with a high listener popularity.
select track_name, genre, popularity
from SpotifyFeatures 
order by popularity desc 
limit 50

-- Q1.3 Checking if runtime of a song plays a part in popularity.
select 	 
	case 
      when duration_ms < 240000 and duration_ms > 180000
        then 'Runtime: 3 Mins'
      when duration_ms < 180000 and duration_ms > 120000
        then 'Runtime: 2 Mins'
      when duration_ms < 120000 and duration_ms > 60000
        then 'Runtime: 1 Mins'
      when duration_ms < 60000 and duration_ms > 0
        then 'Runtime: Less than 1 Min'
      else 'Runtime: Greater than 3 Mins'
    end as 'runtime', avg(popularity) as 'average popularity'
from SpotifyFeatures 
group by case 
      when duration_ms < 240000 and duration_ms > 180000
        then 'Runtime: 3 Mins'
      when duration_ms < 180000 and duration_ms > 120000
        then 'Runtime: 2 Mins'
      when duration_ms < 120000 and duration_ms > 60000
        then 'Runtime: 1 Mins'
      when duration_ms < 60000 and duration_ms > 0
        then 'Runtime: Less than 1 Min'
      else 'Runtime: Greater than 3 Mins'
    end
order by avg(popularity) desc



-- Q2 Does Tempo of a song have an effect on popularity.

-- Q2.1 Average tempo of most popular songs from dataset.
select avg(tempo) as 'Average Tempo'
from SpotifyFeatures 
where popularity > 80

-- Q2.2 Are there specific tempo's that have a greater overall popularity with audiences?
select 
	  case 
           when tempo < 100 and tempo > 30
               then 'Tempo: Less than 100 BPM'
           when tempo > 100 and tempo < 110
           	   then 'Tempo: 100 BPM'
           when tempo > 110 and tempo < 120
           	   then 'Tempo: 110 BPM'
           when tempo > 120 and tempo < 130
           	   then 'Tempo: 120 BPM'
           when tempo > 130 and tempo < 140
           	   then 'Tempo: 130 BPM'
           when tempo > 140 and tempo < 150
           	   then 'Tempo: 140 BPM'
           when tempo > 150 and tempo < 160
           	   then 'Tempo: 150 BPM'
           when tempo > 160 and tempo < 170
           	   then 'Tempo: 160 BPM'
           when tempo > 170 and tempo < 180
           	   then 'Tempo: 170 BPM'
           when tempo > 180 and tempo < 190
           	   then 'Tempo: 180 BPM'
           when tempo > 200 and tempo < 190
           	   then 'Tempo: 190 BPM'
           else 'Tempo: Greater than 200 BPM'
       end as 'Rounded Tempo' , avg(popularity) as 'Average Popularity'
from SpotifyFeatures 
group by case 
           when tempo < 100 and tempo > 30
               then 'Tempo: Less than 100 BPM'
           when tempo > 100 and tempo < 110
           	   then 'Tempo: 100 BPM'
           when tempo > 110 and tempo < 120
           	   then 'Tempo: 110 BPM'
           when tempo > 120 and tempo < 130
           	   then 'Tempo: 120 BPM'
           when tempo > 130 and tempo < 140
           	   then 'Tempo: 130 BPM'
           when tempo > 140 and tempo < 150
           	   then 'Tempo: 140 BPM'
           when tempo > 150 and tempo < 160
           	   then 'Tempo: 150 BPM'
           when tempo > 160 and tempo < 170
           	   then 'Tempo: 160 BPM'
           when tempo > 170 and tempo < 180
           	   then 'Tempo: 170 BPM'
           when tempo > 180 and tempo < 190
           	   then 'Tempo: 180 BPM'
           when tempo > 200 and tempo < 190
           	   then 'Tempo: 190 BPM'
           else 'Tempo: Greater than 200 BPM'
       end 
  order by avg(popularity) desc

-- Q2.3 Taking the top 20 songs and seeing how closely they are to the average tempo of the most popular songs.
 select track_name, round(tempo) as 'tempo', 
 	case 
 		when round(tempo) between 113 and 133 then 'Within 10 BPM'
 		when (round(tempo) between 103 and 113) or (round(tempo) between 123 and 133) then 'Within 20 BPM'
 		when (round(tempo) between 93 and 103) or (round(tempo) between 133 and 143) then 'Within 30 BPM'
  		else 'Greater than 30 BPM'
  	end as 'Distance From Average'
  	from SpotifyFeatures 
  	order by popularity desc
  	limit 20
  
  
-- Q3 Danceability and its’ effect on Listener Popularity.

-- Q3.1 Danceability with genre and popularity.
select distinct genre, avg(popularity) as 'Average Popularity', avg(danceability) * 100 as 'Average Danceability'
from SpotifyFeatures 
group by genre
order by avg(popularity) desc

-- Q3.2 Time signature and how it impacts danceability.
select distinct time_signature, avg(danceability) * 100 as 'Average Danceability'
from SpotifyFeatures 
group by time_signature 
order by avg(danceability) desc

-- Q3.3 Taking the top 20 songs and seeing their danceability and time siganture.
select track_name, danceability * 100 as 'danceability', time_signature
from SpotifyFeatures 
order by popularity desc 
limit 20




-- Q4 How does valence and energy play a part in listener popularity.

-- Q4.1 Checking if musical modes have an impact on valence or energy of a song.
select distinct mode, avg(energy) * 100 as 'Average Energy', avg(valence) * 100 as 'Average Valence'
from SpotifyFeatures 
group by mode

-- Q4.2 Taking the top 20 songs and comparing their energy and valence.
select track_name, mode, energy * 100 as 'energy', valence * 100 as 'valence'
from SpotifyFeatures 
order by popularity desc 
limit 20

-- Q4.3 Valence and its' effect on popularity grouped by genres.
select distinct genre, avg(valence) * 100 as 'Average Valence', avg(popularity) as 'Average Popularity'
from SpotifyFeatures 
group by genre
order by avg(popularity) desc
