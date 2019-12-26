use std::env;
use std::io::{stdin, stdout, Write};
use std::path::PathBuf;
use std::process;

mod intcode;

use intcode::{IntcodeComputer, Status};

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

    let mem = intcode::read_file(&in_path).unwrap_or_else(|e| {
        eprintln!("error: {}", e);
        process::exit(1);
    });

    let mut comp = IntcodeComputer::new()
        .load_mem_pad(&mem)
        .debug(false)
        .init();

    loop {
        if comp.status == Status::WaitingForInput {
            comp.give_input(get_input());
        }

        comp.run().unwrap_or_else(|e| {
            eprintln!("error in execution: {}", e);
        });

        if flag("--ascii") {
            comp.outputs
                .drain(..)
                .for_each(|o| print!("{}", (o as u8) as char));
        } else {
            let out: Vec<_> = comp.outputs.drain(..).collect();
            println!("{:?}", out);
        };
    }
}

fn get_input() -> i64 {
    loop {
        let mut s = String::new();
        print!("input> ");
        let _ = stdout().flush();
        if let Err(_) = stdin().read_line(&mut s) {
            continue;
        }
        if let Ok(i) = s.trim().parse::<i64>() {
            return i;
        }
    }
}
