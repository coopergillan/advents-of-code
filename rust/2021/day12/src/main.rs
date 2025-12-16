// Advent of Code solver

// use std::cmp::Ordering;
// use std::collections::BinaryHeap;
use std::collections::HashMap;
use std::fs;

// #[derive(Copy, Clone, Debug, Eq, PartialEq)
// struct State {
//     node_position: &str,
//     cost: usize,
// }
//
// // The priority queue depends on `Ord`.
// // Explicitly implement the trait so the queue becomes a min-heap
// // instead of a max-heap
//
// impl Ord for State {
//     fn cmp(&self, other: &Self) -> Ordering {
//     // The ordering on costs is flipped to prioritize the smallest
//     // In case of a tie the node positions are compared - this step is necessary
//     // to make implementations of `PartialEq` and `Ord` consistent
//     other.cost.cmp(&self.cost).then_with(|| self.node_position
// }
//
// #[derive(Debug, PartialEq)]
// struct TopLevelStructMultipleIntsPerLine {
//     // For a graph type of problem use a vector of vectors
//     input_data: Vec<Vec<usize>>,
// }
//
// impl TopLevelStructMultipleIntsPerLine {
//     // For one value per line use a vector of integers
//     // If negative numbers needed, change to usize
//     fn new(input_data: Vec<Vec<usize>>) -> Self {
//         TopLevelStructMultipleIntsPerLine { input_data }
//     }
//
//     fn from_file(file_path: &str) -> Self {
//         // For reading each line into an array
//         let raw_content = fs::read_to_string(file_path).expect("Unable to read file");
//
//         let processed_contents: Vec<Vec<usize>> = raw_content
//             .lines()
//             .map(|line| {
//                 line.split(",")
//                     .map(|v| v.parse::<usize>().expect("Unable to parse"))
//                     .collect() // Inside Vec<usize> created here
//             })
//             .collect();
//
//         println!(
//             "Creating struct with processed contents: {:?}",
//             processed_contents
//         );
//         Self::new(processed_contents)
//     }
// }

#[derive(Debug, PartialEq)]
struct TopLevelStructOneStringPerLine {
    // Accept the input as one attribute - use isize if negative numbers needed
    // For one value per line use a vector of integers
    input_data: Vec<String>,
}

impl TopLevelStructOneStringPerLine  {
    // For one value per line use a vector of integers
    fn new(input_data: Vec<String>) -> Self {
        TopLevelStructOneStringPerLine { input_data }
    }

    fn from_file(file_path: &str) -> Self {
        // For reading each line into an array
        let raw_content = fs::read_to_string(file_path).expect("Unable to read file");

        // Process the content - for example change number in each line to an integer
        let raw_content_lines = raw_content.lines();
        let processed_content = raw_content_lines.map(|line| line.to_string()).collect();
        Self::new(processed_content)
    }

    fn process_data(&self) -> HashMap<&str, Vec<&str>> {
        let mut processed_data = HashMap::<&str, Vec<&str>>::new();

        for mapping in &self.input_data {
            dbg!(&mapping);
            let (key, value)  = mapping.split_once("-").expect("Couldn't unpack");
            dbg!(&key, &value);
            processed_data.entry(key).or_insert(Vec::new()).push(value);
            // dbg!(&processed_data);
        }

        processed_data
    }
}

// #[derive(Copy, Clone, Debug, Eq, PartialEq)]
// struct Edge {
//     node: &str,
//     cost: usize,
// }

fn main() {
    println!("Hello world");
    let input_file = "test_input_small.txt";

    let top_level = TopLevelStructOneStringPerLine::from_file(input_file);
    dbg!(&top_level);
    dbg!(&top_level.process_data());

    // println!("Part 1 answer: {}", top_level.solve_part1());
    // println!("Part 2 answer: {}", top_level.solve_part2());
}

// #[cfg(test)]
// mod tests {
//     use super::*;
//
//     #[test]
//     fn test_from_file_top_level_one_int_per_line() {
//         let input_file = "test_input_one_int_per_line.txt";
//         let top_level = TopLevelStructOneIntPerLine::from_file(input_file);
//         assert_eq!(top_level.input_data, vec![5, 9, 13, 4])
//     }
//
//     #[test]
//     fn test_from_file_top_level_multiple_ints_per_line() {
//         let input_file = "test_input_multiple_ints_per_line.txt";
//         let top_level = TopLevelStructMultipleIntsPerLine::from_file(input_file);
//         println!("top_level_struct.input_data: {:?}", top_level.input_data);
//         assert_eq!(
//             top_level.input_data,
//             vec![
//                 vec![5, 7, 13, 2],
//                 vec![9, 314, 2718, 17],
//                 vec![13, 8, 7, 4],
//                 vec![4, 22, 19, 33],
//                 vec![5, 20, 79, 13],
//             ]
//         )
//     }
//
//     #[test]
//     fn test_from_file_top_level_double_line_breaks() {
//         let input_file = "test_double_line_break_input.txt";
//         let top_level = TopLevelStructDoubleLineBreak::from_file(input_file);
//         println!("top_level_struct.input_data: {:?}", top_level.input_data);
//         assert_eq!(
//             top_level.input_data,
//             vec![
//                 vec![1000, 2000, 3000],
//                 vec![4000],
//                 vec![5000, 6000],
//                 vec![7000, 8000, 9000],
//                 vec![10000],
//             ]
//         )
//     }
//
//     #[test]
//     fn test_part1() {
//         assert_eq!(5, 6);
//     }
//
//     #[test]
//     fn test_part2() {
//         assert_eq!(22, 10);
//     }
// }
