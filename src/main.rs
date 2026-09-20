use anyhow::Result;
use clap::Parser;

use flacx::*;
use std::fs::*;
use std::io::*;
// dumb test CLI for now..
#[derive(Parser, Debug)]
struct Args {
    #[arg(short, long)]
    path: String,
    #[arg(short)]
    bands_num: u32,
    #[arg(short)]
    preamp: bool,
}

pub fn convert_flac(path: String) -> anyhow::Result<()> {
    let file = File::open(&path)?;
    let input = BufReader::new(file);
    let source = read_flac_reader(input)?.into_decode_source();

    let output = BufWriter::new(File::create("output.wav")?);
    let mut decoder = DecodeConfig::default().into_decoder(output);
    decoder.decode_source(source)?;
    Result::Ok(())
}

fn main() -> anyhow::Result<()> {
    let args = Args::parse();
    convert_flac(args.path)?;
    print!("hello sir....");
    Ok(())
}
