### Unit tests for segsample.R functions

library(CNprep)


### Tests segsample() results

context("segsample() results")

test_that("segsample() must return expected results 01", {
    
    segData <- data.frame(StartProbe=c(1, 7, 13),
                          EndProbe=c(6, 12, 15),
                          chrom=c(1,1,1),
                          segmedian=c(0.08662475, 0.07319237, 0.07689544),
                          segmad=c(0.06404208, 0.04764233, 0.08833202))
    ratcol <- c(0.072073840, 0.119913919,  0.154459489,  0.040994620, -0.082843732, 
                0.093052725,  0.170908930,  0.100289490,  0.086624752, -0.003855011, 
                -0.195791649, 0.063634112,  0.109449474,  0.043428961,  0.160174529)
    
    
    RNGkind("default")
    
    set.seed(222)
    
    results <- CNprep:::segsample(mysegs=segData, ratcol=ratcol, 
                                    startcol="StartProbe", endcol="EndProbe",
                                    blocksize=5, times=0)
    
    colnames(results)[3] <- "results"
    
    expected <- data.frame(StartProbe=c(1, 7),
                           EndProbe=c(6, 12),
                           results=c(0.093052725000, 0.135599210000))
    
    expect_equal(results, expected)
})

test_that("segsample() must return expected results 02", {
    
    segData <- data.frame(StartProbe=c(1, 9, 14),
                          EndProbe=c(8, 13, 15),
                          chrom=c(1,1,1),
                          segmedian=c(0.08662475, 0.07319237, 0.07689544),
                          segmad=c(0.06404208, 0.04764233, 0.08833202))
    ratcol <- c(0.066076840, 0.119916919,  0.124456689,  0.046694620, -0.077843732, 
                0.011052725,  0.178808930,  0.122289490,  0.086624752, -0.003855011, 
                -0.195791649, 0.063634112,  0.111449474,  0.043428961,  0.160174529)
    
    
    RNGkind("default")
    
    set.seed(2222)
    
    results <- CNprep:::segsample(mysegs=segData, ratcol=ratcol, startcol="StartProbe", endcol="EndProbe",
                                  blocksize = 4)
    
    colnames(results)[3] <- "results"
    
    expected <- data.frame(StartProbe=c(1, 1, 9),
                           EndProbe=c(8, 8, 13),
                           results=c(0.094183165000, 0.066076840000, 
                                        0.063634112000))
    row.names(expected) <- c("1",   "1.1", "2")
    
    expect_equal(results, expected)
})

test_that("segsample() must return expected results when using parameter times 01", {
    
    segData <- data.frame(StartProbe=c(1, 9, 14),
                          EndProbe=c(8, 13, 15),
                          chrom=c(1,1,1),
                          segmedian=c(0.08662475, 0.07319237, 0.07689544),
                          segmad=c(0.06404208, 0.04764233, 0.08833202))
    ratcol <- c(0.066076840, 0.119916919,  0.124456689,  0.046694620, -0.077843732, 
                0.011052725,  0.178808930,  0.122289490,  0.086624752, -0.003855011, 
                -0.195791649, 0.063634112,  0.111449474,  0.043428961,  0.160174529)
    
    
    RNGkind("default")
    
    set.seed(222)
    
    results <- CNprep:::segsample(mysegs=segData, ratcol=ratcol, 
                                    startcol="StartProbe", endcol="EndProbe",
                                    times=2)
    
    colnames(results)[3] <- "results"
    
    expected <- data.frame(StartProbe=c(1, 1, 9, 9, 14, 14),
                           EndProbe=c(8, 8, 13 , 13, 15, 15),
                           results=c(0.119916919000, 0.066076840000, 
                                     0.063634112000, 0.086624752000, 
                                     0.043428961000, 0.160174529000))
    row.names(expected) <- c("1", "1.1", "2", "2.1", "3", "3.1")
    
    expect_equal(results, expected)
})

test_that("segsample() must return expected results when using parameter times 02", {
    
    segData <- data.frame(StartProbe=c(1, 7, 13),
                          EndProbe=c(6, 12, 15),
                          chrom=c(1,1,1),
                          segmedian=c(0.08662475, 0.07319237, 0.07689544),
                          segmad=c(0.06404208, 0.04764233, 0.08833202))
    ratcol <- c(0.072073840, 0.119913919,  0.154459489,  0.040994620, -0.082843732, 
                0.093052725,  0.170908930,  0.100289490,  0.086624752, -0.003855011, 
                -0.195791649, 0.063634112,  0.109449474,  0.043428961,  0.160174529)
    
    
    RNGkind("default")
    
    set.seed(23322)
    
    results <- CNprep:::segsample(mysegs=segData, ratcol=ratcol, startcol="StartProbe", endcol="EndProbe",
                                    times=3)
    
    colnames(results)[3] <- "results"
    
    expected <- data.frame(StartProbe=c(1, 1, 1, 7, 7, 7, 13, 13, 13),
                           EndProbe=c(6, 6, 6, 12, 12, 12, 15, 15, 15),
                           results=c(0.095993879500, -0.005384946000, 
                                        0.093052725000, 0.086624752000,
                                        -0.003855011000, 0.081961801000, 
                                        0.160174529000, 0.109449474000,
                                        0.109449474000))
    row.names(expected) <- c("1", "1.1", "1.2", "2", "2.1", "2.2", "3", "3.1", "3.2")
    
    expect_equal(results, expected)
})

test_that("segsample() must return error when times and blocksize not set", {
    
    message = "One of blocksize or times must be set"
    
    segData <- data.frame(StartProbe=c(1, 7, 13),
                          EndProbe=c(6, 12, 15),
                          chrom=c(1,1,1),
                          segmedian=c(0.08662475, 0.07319237, 0.07689544),
                          segmad=c(0.06404208, 0.04764233, 0.08833202))
    ratcol <- c(0.072073840, 0.119913919,  0.154459489,  0.040994620, -0.082843732, 
                0.093052725,  0.170908930,  0.100289490,  0.086624752, -0.003855011, 
                -0.195791649, 0.063634112,  0.109449474,  0.043428961,  0.160174529)
    
    
    expect_error(CNprep:::segsample(mysegs=segData, ratcol=ratcol, 
                                startcol="StartProbe", endcol="EndProbe"), 
                 message)
})

test_that("segsample() must return error when both times and blocksize set", {
    
    message = "Only one of blocksize or times can be set"
    segData <- data.frame(StartProbe=c(1, 7, 13),
                          EndProbe=c(6, 12, 15),
                          chrom=c(1,1,1),
                          segmedian=c(0.08662475, 0.07319237, 0.07689544),
                          segmad=c(0.06404208, 0.04764233, 0.08833202))
    ratcol <- c(0.072073840, 0.119913919,  0.154459489,  0.040994620, -0.082843732, 
                0.093052725,  0.170908930,  0.100289490,  0.086624752, -0.003855011, 
                -0.195791649, 0.063634112,  0.109449474,  0.043428961,  0.160174529)
    
    
    expect_error(CNprep:::segsample(mysegs=segData, ratcol=ratcol, times = 3, 
                                    blocksize = 3,
                                    startcol="StartProbe", endcol="EndProbe"), 
                 message)
})
