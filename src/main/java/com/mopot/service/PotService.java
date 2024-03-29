package com.mopot.service;


import com.mopot.domain.PotContent;
import com.mopot.repository.PotRepository;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;

@Service
public class PotService {

    @Autowired
    PotRepository potRepository;


    public PotContent insert(PotContent potContent) {
        return potRepository.save(potContent);
    }


    public PotContent update(PotContent potContent) {
        PotContent rPotcontent = potRepository.findById(potContent.getPotNo()).orElse(null);
        rPotcontent.setPotTitle(potContent.getPotTitle());
        rPotcontent.setPotDetail(potContent.getPotDetail());
        rPotcontent.setPotWriter(potContent.getPotWriter());
        rPotcontent.setPotTag(potContent.getPotTag());
        rPotcontent.setPotCategory(potContent.getPotCategory());
        return potRepository.save(rPotcontent);
    }


    public void potContentDelete(long potNo) {
        potRepository.deleteById((long) potNo);

    }


    public Page<PotContent> potList(Pageable pageable) {
        return potRepository.findAll(pageable);
    }

    public List<PotContent> findPotsByCategory(String potCategory) {

        return potRepository.findByPotCategory(potCategory);
    }

    public Page<PotContent> potCategoryList(String searchType, Pageable pageable) {
        return potRepository.findByPotCategory(searchType, pageable);
    }


    public Optional<PotContent> updateNowHeadcountPlus(@NonNull Long potNo) {
        return potRepository.findById(potNo).map(potContent -> {
            potContent.setPotNowHeadcount(potContent.getPotNowHeadcount() + 1);
            return potRepository.save(potContent);
        });
    }

    public Optional<PotContent> updateNowHeadcountMinus(@NonNull Long potNo) {
        return potRepository.findById(potNo).map(potContent -> {
            potContent.setPotNowHeadcount(potContent.getPotNowHeadcount() - 1);
            return potRepository.save(potContent);
        });
    }

}
