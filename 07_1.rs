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

    println!("{}", amp(&mem, 20000, 0));
    let mut count = 0;
    for a in 0..=4 {
        for b in 0..=4 {
            for c in 0..=4 {
                for d in 0..=4 {
                    for e in 0..=4 {
                        count += 1;
                    }
                }
            }
        }
    }
    println!("{}", count);
}

fn amp(mem: &Vec<i64>, input: i64, phase: i64) -> i64 {
    let mut comp = IntcodeComputer::new()
        .load_mem(mem.clone())
        .input(phase)
        .input(input)
        .debug(false)
        .init();

    comp.run().unwrap_or_else(|e| {
        eprintln!("error in execution: {}", e);
    });

    comp.outputs.pop().unwrap()
}