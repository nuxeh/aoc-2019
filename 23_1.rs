use std::env;
use std::process;
use std::path::PathBuf;

mod intcode;

use intcode::IntcodeComputer;

fn main() {
    let in_path: PathBuf = env::args().into_iter().skip(1).take(1).collect();

    let mem = intcode::read_file(&in_path).unwrap_or_else(|e| {
        eprintln!("error: {}", e);
        process::exit(1);
    });

    (0..50).for_each(|n| println!("{}", n));
}

fn spawn_computer(mem: &[i64], n: usize) -> IntcodeComputer {
    IntcodeComputer::new()
        .load_mem_pad(mem)
        .input(n as i64)
        .init()
}
