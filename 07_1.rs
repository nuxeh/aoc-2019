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

    let mut count = 0;
    let mut best = 0;
    let mut best_phases = Vec::new();
    for a in 0..=4 {
        for b in 0..=4 {
            for c in 0..=4 {
                for d in 0..=4 {
                    for e in 0..=4 {
                        count += 1;
                        let out = chain(&mem, a, b, c, d, e);
                        if out > best {
                            best = out;
                            best_phases = vec!(a, b, c, d, e);
                        }
                    }
                }
            }
        }
    }
    println!("{}", count);
    println!("{}", best);
    println!("{:?}", best_phases);
}

fn chain(mem: &Vec<i64>, a: i64, b: i64, c: i64, d: i64, e: i64) -> i64 {
    let l = amp(mem, 0, a);
    let m = amp(mem, l, b);
    let n = amp(mem, m, c);
    let o = amp(mem, n, d);
    amp(mem, o, e)
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
