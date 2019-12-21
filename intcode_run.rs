use std::env;
use std::process;
use std::path::PathBuf;

mod intcode;

use intcode::IntcodeComputer;

fn flag(flag: &str) -> bool {
    for arg in env::args() {
        if arg == flag {
            return true;
        }
    }
    false
}

fn main() {
    let in_path: PathBuf = env::args().into_iter().skip(1).take(1).collect();
    let input: String = env::args().into_iter().skip(2).take(1).collect();

    let mem = intcode::read_file(&in_path).unwrap_or_else(|e| {
        eprintln!("error: {}", e);
        process::exit(1);
    });

    let mut comp = IntcodeComputer::new()
        .load_mem_pad(&mem)
        .input(input.parse().unwrap())
        .debug(false)
        .init();

    comp.run().unwrap_or_else(|e| {
        eprintln!("error in execution: {}", e);
    });

    if flag("--ascii") {
        comp.outputs.iter().for_each(|o| print!("{}", (*o as u8) as char));
    } else {
        println!("{:?}", comp.outputs);
    };
}
