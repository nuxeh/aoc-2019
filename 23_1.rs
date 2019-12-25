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
    display_io(&computers);
    run(&mut computers).unwrap_or_else(|e| {
        eprintln!("error: {}", e);
        process::exit(1);
    });
    display_status(&computers);
    display_io(&computers);
}

fn run(computers: &mut [IntcodeComputer]) -> Result<(), Box<dyn Error>> {
    for c in computers {
        c.run()?
    }
    Ok(())
}

fn display_status(computers: &[IntcodeComputer]) {
    for (i, c) in computers.iter().enumerate() {
        print!("[{:<2}] {:<16}", i, format!("{:?}", c.status));
        if (i + 1) % 4 == 0 {
            println!("");
        }
    }
    println!("");
}

fn display_io(computers: &[IntcodeComputer]) {
    for (i, c) in computers.iter().enumerate() {
        println!("[{:<2}] {:?} {:?}", i, c.outputs, c.inputs);
    }
}

fn distribute() {}

fn spawn_computer(mem: &[i64], n: usize) -> IntcodeComputer {
    IntcodeComputer::new()
        .load_mem_pad(mem)
        .input(n as i64)
        .input(-1)
        .debug(false)
        .init()
}
