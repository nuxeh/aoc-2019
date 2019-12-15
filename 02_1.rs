use std::env;
use std::path::PathBuf;

mod intcode;

use intcode::Intcode;

fn main() {
    let in_path: PathBuf = env::args().into_iter().skip(1).take(1).collect();
    let mem = intcode::read_file(&in_path);
    println!("{:?}", in_path);
    println!("{:?}", mem);
    println!("{:?}", Intcode::get(&mem.unwrap(), 0));
}
