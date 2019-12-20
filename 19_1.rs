use std::env;
use std::process;
use std::path::PathBuf;

mod intcode;

use intcode::IntcodeComputer;

fn get_coord(mem: &[i64], x: i64, y: i64) -> bool {
    let mut comp = IntcodeComputer::new()
        .load_mem_pad(mem)
        .input(x)
        .input(y)
        .debug(false)
        .init();

    comp.run().unwrap_or_else(|e| {
        eprintln!("error in execution: {}", e);
    });

    if Some(1) == comp.outputs.pop() {
        true
    } else {
        false
    }
}

fn main() {
    let in_path: PathBuf = env::args().into_iter().skip(1).take(1).collect();

    let mem = intcode::read_file(&in_path).unwrap_or_else(|e| {
        eprintln!("error: {}", e);
        process::exit(1);
    });

    for y in 0..50 {
        for x in 0..50 {
            if get_coord(&mem, x, y) {
                print!("#");
            } else {
                print!(".");
            }
        }
        print!("\n");
    };
}
