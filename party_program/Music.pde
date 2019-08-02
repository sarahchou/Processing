import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;

ArrayList<String> songs;

void setupAudio()
{
  minim = new Minim(this);
  song = minim.loadFile("songs/Feel_Good.mp3");
  song.pause();
  beat = new BeatDetect(1024, 44100);
  beat.setSensitivity(8);
  songs = new ArrayList<String>();
  setupSongs();
}

void setupSongs() {
  

  //first song 0
  songs.add("songs/Feel_Good.mp3");
  //second song 1
  songs.add("songs/Takeaway.mp3");
  //third song 2
  songs.add("songs/Good_Things_Fall_Apart.mp3");
  songs.add("songs/OldTownRoad.mp3");
  songs.add("songs/WiiMusic.mp3");
  songs.add("songs/FridayNight.mp3");
  songs.add("songs/Despacito.mp3");
  songs.add("songs/betonit.mp3");
  songs.add("songs/IWantItThatWay.mp3");
}

void chooseSong(int num) {
  int index = num == 0 ? songs.size() - 1 : num - 1;
  song.pause();
  String songTitle = index >= songs.size() ? songs.get(0) : songs.get(index);
  song = minim.loadFile(songTitle);
  song.play();
}
