use std::env;
use std::error::Error;
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

    let mut computers: Vec<_> = (0..50)
        .map(|n| spawn_computer(&mem, n))
        .collect();

    display_status(&computers);
    run(&mut computers);
    display_status(&computers);
}

fn run(computers: &mut [IntcodeComputer]) -> Result<(), Box<dyn Error>> {
    for c in computers {
        c.run()?
    }
    Ok(())
}

fn display_status(computers: &[IntcodeComputer]) {
    for (i, c) in computers.iter().enumerate() {
        println!("[{}] {:?}", i, c.status);
    }
}

fn distribute() {}

fn spawn_computer(mem: &[i64], n: usize) -> IntcodeComputer {
    IntcodeComputer::new()
        .load_mem_pad(mem)
        .input(n as i64)
        .debug(false)
        .init()
}
