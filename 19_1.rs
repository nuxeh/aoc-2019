mod intcode;

use std::env;
use std::process;
use std::path::PathBuf;
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
    let dim: i64 = env::args().into_iter().skip(2).take(1).collect::<String>().parse().unwrap();

    let mem = intcode::read_file(&in_path).unwrap_or_else(|e| {
        eprintln!("error: {}", e);
        process::exit(1);
    });

    let mut c = 0;
    for y in 0..dim {
        for x in 0..dim {
            if get_coord(&mem, x, y) {
                print!("#");
                c += 1;
            } else {
                print!(".");
            }
        }
        print!("\n");
    };
    eprintln!("{}", c);
}
