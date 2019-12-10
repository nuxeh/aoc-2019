use std::env;
use std::path::PathBuf;

mod intcode;

fn main() {
    let in_path: PathBuf = env::args().into_iter().skip(1).take(1).collect();
    let mem = intcode::read(&in_path);
    println!("{:?}", in_path);
    println!("{:?}", mem);
}
