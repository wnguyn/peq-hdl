use serde::*;

// TODO: finish later; hard coded values for now until I DONT WANT TO PARSE THIS!!!
#[derive(Clone)]
pub enum BandType {
    Bell,
    HighPass,
    LowShelf,
    LowPass,
    LowShelf,
    Notch,
    Resonance,
    Allpass,
    Ladderpass,
    LadderRej,
}
#[derive(Clone)]
pub enum Preamp {
    No,
    Gain(usize),
    UnGain(usize),
}

#[derive(Clone)]
pub struct Config {
    filter: Vec<Bands>,
    preamp: PreAmp,
}

#[derive(Clone)]
pub struct Config {
    // this truncates at 48kHz
    freq: u32,
    gain: i32,
    quality: f32,
}

impl Config {}
