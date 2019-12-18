use std::env;
use std::process;
use std::path::PathBuf;

mod intcode;

use intcode::{Intcode, IntcodeComputer};

fn main() {
    let in_path: PathBuf = env::args().into_iter().skip(1).take(1).collect();
    println!("{:?}", in_path);

    let mem = intcode::read_file(&in_path).unwrap_or_else(|e| {
        eprintln!("error: {}", e);
        process::exit(1);
    });

    println!("{:?}", mem);

    let mut comp = IntcodeComputer::new()
        .load_mem(mem)
        .init();

    println!("{:?}", Intcode::get(&comp));
    println!("{:?}", comp);

    comp.run().unwrap_or_else(|e| {
        eprintln!("error in execution: {}", e);
    });

    println!("{}", comp.mem[0]);
}
