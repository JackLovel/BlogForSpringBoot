package com.example.demo.service;


import com.example.demo.po.Tag;
import org.springframework.data.domain.*;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
 * 标签相关的
 */
public interface TagService {
   Tag saveTag(Tag tag);
   Tag getTag(Long id);
   Tag getTagByName(String name);
   Page<Tag> listTag(Pageable pageable);
   List<Tag> listTag();
   List<Tag> listTagTop(Integer size);
   List<Tag> listTag(String ids);
   Tag updateTag(Long id,Tag Tag);
   void deleteTag(Long id);
}
